from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session
from passlib.context import CryptContext
from .routers import user
from . import models, schemas, crud, auth
from .database import SessionLocal, engine, Base
from .routers import user 


Base.metadata.create_all(bind=engine)


app = FastAPI()
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
app.include_router(user.router)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.post("/register", response_model=schemas.UserOut)
def register(user: schemas.UserCreate, db: Session = Depends(get_db)):
    print("📥 Received registration:", user.dict())
    if db.query(models.User).filter(models.User.email == user.email).first():
        raise HTTPException(status_code=400, detail="Email already registered")

    hashed_password = auth.get_password_hash(user.password)

    new_user = models.User(
        email=user.email,
        hashed_password=hashed_password,
        full_name=user.full_name,
        phone_number=user.phone_number,
        address=user.address,
    )

    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return new_user




@app.post("/login")
def login(user: schemas.UserLogin, db: Session = Depends(get_db)):
    db_user = db.query(models.User).filter(models.User.email == user.email).first()
    if not db_user:
        raise HTTPException(status_code=400, detail="Invalid email or password")
    
    if not pwd_context.verify(user.password, db_user.hashed_password):
        raise HTTPException(status_code=400, detail="Invalid email or password")

    return {
        "id": db_user.id,
        "email": db_user.email,
        "full_name": db_user.full_name,
        "phone_number": db_user.phone_number,
        "address": db_user.address
    }

app.include_router(user.router, prefix="/api", tags=["Users"])
app.include_router(auth.router, prefix="/api", tags=["Auth"])
