from pydantic import BaseModel
from typing import Optional

class UserCreate(BaseModel):

    email: str
    password: str
    full_name: str
    phone_number: str
    address: str

class UserResponse(BaseModel):
    id: int
    email: str
    full_name: str
    phone_number: str
    address: str

    model_config = {
        "from_attributes": True
    }


class UserLogin(BaseModel):
    email: str
    password: str

class UserOut(BaseModel):
    id: int
    email: str
    full_name: str
    phone_number: str
    address: str

    model_config = {
        "from_attributes": True
    }

class UserUpdate(BaseModel):
    name: Optional[str]
    email: Optional[str]
    phone_number: Optional[str]
    emergency: Optional[str]
    address: Optional[str]        

