# CI/CD Pipeline for a Flask Application

This project implements a complete **CI/CD (Continuous Integration/Continuous Deployment)** pipeline for a simple web application written in **Python** using the **Flask** framework. The main goal is to demonstrate key **DevOps** skills, including automation, containerization, and deployment management.

The entire process, from fetching the code to the final deployment, is automated by **Jenkins** using the **Pipeline as Code** concept (`Jenkinsfile`).

---

## Project Architecture

The architecture is simple yet effective. The end-user accesses the application through the **Nginx** web server, which acts as a reverse proxy, forwarding traffic to the **Docker** container where the Flask app is running.
+-----------------+      +-------------------------+      +---------------------------------+
|   User/Browser  |----->|  Debian VM (Port 80)    |----->|   Docker Container (Port 5000)  |
|                 |      | +---------------------+ |      | +-----------------------------+ |
|                 |      | |       Nginx         | |      | |          Flask App          | |
|                 |      | |   (Reverse Proxy)   | |      | |                             | |
|                 |      | +---------------------+ |      | +-----------------------------+ |
+-----------------+      +-------------------------+      +---------------------------------+

---

## Technologies Used

* **CI/CD Server:** **Jenkins**
* **Containerization:** **Docker**
* **Web Server / Reverse Proxy:** **Nginx**
* **Application Framework:** **Python (Flask)**
* **Infrastructure:** **Debian 12 Virtual Machine**
* **Version Control:** **Git & GitHub**
* **Scripting:** **Groovy** (for `Jenkinsfile`) and **Bash**

---

## Key Features

* **Full Automation**: The pipeline automatically fetches the code, builds a new Docker image, and updates the application upon execution.
* **Pipeline as Code**: All pipeline stages are defined in a `Jenkinsfile`, which is version-controlled alongside the application code.
* **Zero-Downtime Deployment Strategy**: By stopping the old container and immediately replacing it with the new one, downtime is minimized.
* **Isolated & Portable Environment**: Using Docker ensures that the application and its dependencies run in an isolated and portable environment.

---

## Pipeline Stages (`Jenkinsfile`)

The pipeline is defined with the following core stages:

1.  **Build Docker Image**:
    * In this stage, Jenkins uses the `Dockerfile` in the project root to build a new application image.
    * To avoid conflicts, each new image is tagged with the unique Jenkins build number (e.g., `python-flask-app:1`, `python-flask-app:2`).

2.  **Deploy Application**:
    * First, the previously running container (if it exists) is stopped using `docker stop`.
    * It is then removed with `docker rm`.
    * Finally, a new container is started in detached mode (`-d`) from the image created in the previous stage.

3.  **Post Actions (Cleanup)**:
    * After the pipeline finishes (on success or failure), the `docker image prune` command is executed to remove any dangling images, preventing disk space from filling up.
