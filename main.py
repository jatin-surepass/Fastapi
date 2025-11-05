from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "FastAPI Docker Demo Running!"}

@app.get("/hello/{name}")
def read_item(name: str):
    return {"message": f"Hello {name}, welcome to FastAPI!"}
