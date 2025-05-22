from pydantic import BaseModel

class UserCreate(BaseModel):
    email: str
    password: str
    full_name: str
    phone: str
    address: str

class UserResponse(BaseModel):
    id: int
    email: str
    full_name: str
    phone: str
    address: str

    class Config:
        orm_mode = True

class UserLogin(BaseModel):
    email: str
    password: str
