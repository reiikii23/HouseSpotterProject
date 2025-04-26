from pydantic import BaseModel

class FruitCreate(BaseModel): 
    name: str
    seedless: bool = True

class FruitOut(FruitCreate):
    id: int

    class Config:
        orm_mode = True