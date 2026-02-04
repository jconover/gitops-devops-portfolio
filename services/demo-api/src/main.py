from fastapi import FastAPI

app = FastAPI(title="Demo Control Plane API")

@app.get("/healthz")
def healthz() -> dict:
    return {"status": "ok"}

@app.get("/message")
def message() -> dict:
    return {"message": "GitOps FTW"}
