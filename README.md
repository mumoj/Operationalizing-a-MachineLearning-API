# Operationalizing a Machine Learning API

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/mumoj/operationalizing-a-ml-api/tree/master.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/mumoj/operationalizing-a-ml-api/tree/master)

This project demonstrates how to operationalize a machine learning microservice API using Docker and Kubernetes. The API serves predictions from a pre-trained `sklearn` model that predicts housing prices in Boston based on various features.

## Project Overview

This application:
- Uses a pre-trained sklearn model for Boston housing price prediction
- Containerizes a Flask API using Docker
- Deploys the containerized application using Kubernetes
- Configures a CI/CD pipeline with CircleCI

The model has been trained on the Boston Housing dataset from Kaggle, which includes features such as:
- CHAS: Charles River dummy variable (1 if tract bounds river; 0 otherwise)
- RM: Average number of rooms per dwelling
- TAX: Full-value property tax rate per $10,000
- PTRATIO: Pupil-teacher ratio by town
- B: 1000(Bk - 0.63)² where Bk is the proportion of Black residents by town
- LSTAT: % lower status of the population

## Prerequisites

- Python 3.7
- Docker
- Kubernetes (Minikube or Docker Desktop with Kubernetes)
- Hadolint
- Pylint

## Project Structure

```
.
├── .circleci/                  # CircleCI configuration
│   └── config.yml              # CI pipeline settings
├── model_data/                 # ML model files
│   └── boston_housing_prediction.joblib
├── output_txt_files/           # Application logs
│   ├── docker_out.txt
│   └── kubernetes_out.txt
├── app.py                      # Flask application
├── Dockerfile                  # Docker image definition
├── Makefile                    # Development workflow commands
├── requirements.txt            # Python dependencies
├── run_docker.sh               # Script to build and run Docker container
├── run_kubernetes.sh           # Script to deploy to Kubernetes
├── make_prediction.sh          # Script to test the API
└── upload_docker.sh            # Script to push Docker image to registry
```

## Setup Instructions

### 1. Set Up Environment

Create and activate a Python virtual environment:
```bash
python3 -m pip install --user virtualenv
python3 -m virtualenv --python=python3.7 .devops
source .devops/bin/activate
```

Install dependencies:
```bash
make install
```

### 2. Run Linting Checks

Run linting checks on the application and Dockerfile:
```bash
make lint
```

This will run:
- Hadolint on the Dockerfile
- Pylint on app.py

### 3. Run the Application Locally

To run the application as a standalone Flask app:
```bash
python app.py
```

### 4. Run the Application in Docker

Build and run the application in a Docker container:
```bash
./run_docker.sh
```

This script:
1. Builds a Docker image tagged as 'mlapi'
2. Lists available Docker images
3. Runs the container, mapping port 8000 on the host to port 80 in the container

### 5. Make a Prediction

With the application running (either locally, in Docker, or in Kubernetes), make a prediction:
```bash
./make_prediction.sh
```

This sends a sample housing data payload to the API endpoint and returns a price prediction.

### 6. Upload Docker Image

Upload the Docker image to Docker Hub:
```bash
./upload_docker.sh
```

This script:
1. Tags the Docker image with your Docker Hub username
2. Authenticates with Docker Hub
3. Pushes the image to the Docker Hub repository

### 7. Deploy to Kubernetes

Deploy the application to a Kubernetes cluster:
```bash
./run_kubernetes.sh
```

This script:
1. Pulls the Docker image from Docker Hub
2. Creates a Kubernetes deployment
3. Lists the pods
4. Sets up port forwarding from the pod to your local machine

## API Endpoints

- `GET /`: Home page
- `POST /predict`: Accepts housing feature data and returns a price prediction

### Prediction Payload Example

```json
{
  "CHAS": {"0": 0},
  "RM": {"0": 6.575},
  "TAX": {"0": 296.0},
  "PTRATIO": {"0": 15.3},
  "B": {"0": 396.9},
  "LSTAT": {"0": 4.98}
}
```

## Continuous Integration

This project uses CircleCI for continuous integration. The configuration:
1. Uses Python 3.7.3 Docker image
2. Installs dependencies
3. Runs linting checks
4. Caches dependencies to speed up future builds

## Improvements and Extensions

Possible improvements to this project:
- Add more detailed logging
- Implement a more robust error handling
- Add a web interface for easier interaction
- Extend to support multiple ML models
- Implement automated scaling based on traffic
- Add monitoring and alerting

## License

This project is licensed under the MIT License.

## Acknowledgements

- [Udacity](https://www.udacity.com/) - Project template
- [Boston Housing Dataset](https://www.kaggle.com/c/boston-housing) - Source data for the model
