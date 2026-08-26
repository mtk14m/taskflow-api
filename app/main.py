from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def root():
    return {"status": "ok", "app": "taskflow-api"}


@app.get("/health")
def health_check():
    return {"status": "healthy"}
