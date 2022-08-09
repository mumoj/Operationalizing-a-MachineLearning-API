FROM python:3.7.3-stretch

## Step 1:
WORKDIR /srv/applications/ 

## Step 2:
COPY ./app.py .
COPY ./requirements.txt .
COPY ./model_data ./model_data


## Step 3:
# hadolint ignore=DL3013
RUN pip install --no-cache-dir --upgrade pip &&\
    pip install --no-cache-dir -r requirements.txt


## Step 4:
EXPOSE 80

## Step 5:
CMD ["python3", "app.py"]

