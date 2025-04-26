from fastapi import FastAPI, HTTPException, Depends
from sqlalchemy.orm import Session
from .models import Fruit
from .schemas import FruitCreate, FruitOut
from .database import get_db
app = FastAPI()

@app.get("/")
def index():
    return {"message": "Welcome to FastAPI"}

@app.post("/new")
def create(fruit: FruitCreate, db: Session = Depends(get_db)):
    new_fruit = Fruit(name=fruit.name, seedless=fruit.seedless)
    db.add(new_fruit)
    db.commit()
    db.refresh(new_fruit)
    raise HTTPException(status_code=200, detail="Fruit is successfully saved.")

@app.get("/fruits", response_model=list[FruitOut])
def get_fruits(db: Session = Depends(get_db)):
    fruits = db.query(Fruit).all()
    return fruits

@app.get("/fruits/{fruit_index}", response_model=FruitCreate) 
def get_fruit(fruit_index: int) -> FruitCreate:
    if(fruit_index < len(fruits)):
        return fruits[fruit_index]
    else:
        raise HTTPException(status_code=404, detail="Fruit is missing")