# test_main.py


from fastapi.testclient import TestClient
from main import app

client = TestClient(app)


def test_read_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"Hello": "World"}


def test_read_item():
    response = client.get("/items/1")
    assert response.status_code == 200
    assert response.json() == {"item_id": 1, "q": None}

    response = client.get("/items/1?q=somequery")
    assert response.status_code == 200
    assert response.json() == {"item_id": 1, "q": "somequery"}


def test_update_item():
    item_data = {"name": "Test Item", "price": 10.5, "is_offer": True}
    response = client.put("/items/1", json=item_data)
    assert response.status_code == 200
    assert response.json() == {"item_price": 10.5, "item_id": 1}
