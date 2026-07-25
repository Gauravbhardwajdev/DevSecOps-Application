# 🚀 Enterprise DevSecOps CI/CD Pipeline using GitHub Actions, Docker, Kubernetes & AWS EKS

<p align="center">

![GitHub Actions](https://img.shields.io/badge/GitHub-Actions-2088FF?logo=github-actions&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-EKS-FF9900?logo=amazon-aws&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?logo=kubernetes&logoColor=white)
![SonarQube](https://img.shields.io/badge/SonarQube-Code%20Quality-blue)
![Trivy](https://img.shields.io/badge/Trivy-Security-success)
![Checkov](https://img.shields.io/badge/Checkov-IaC%20Security-green)

</p>

---

# 📌 Overview

This repository demonstrates an **Enterprise DevSecOps CI/CD Pipeline** built using **GitHub Actions**, **Docker**, **Kubernetes**, and **Amazon EKS**.

The goal of this project is to implement a production-inspired DevSecOps workflow by integrating automated security scanning, static code analysis, testing, containerization, image scanning, Software Bill of Materials (SBOM) generation, and Kubernetes deployment.

The pipeline follows **Shift Left Security**, ensuring security checks are performed throughout the Software Development Lifecycle (SDLC) before deployment.

---

# ✨ Features

- Automated GitHub Actions CI/CD Pipeline
- Secret Detection using Gitleaks
- Infrastructure Security Scanning using Checkov
- Filesystem Vulnerability Scanning using Trivy
- Client & Server Linting
- Automated Unit Testing
- SonarQube Static Code Analysis
- SonarQube Quality Gate Validation
- Multi-stage Docker Build
- Docker Image Vulnerability Scanning
- Software Bill of Materials (SBOM) Generation
- Docker Hub Image Publishing
- Automatic Kubernetes Manifest Update
- Kubernetes Deployment to Amazon EKS
- Deployment Rollout Verification

---

# 🏗 Architecture

> Replace the image below after creating your architecture diagram.

![Architecture](docs/architecture.png)

---

# 🔄 CI/CD Pipeline Flow

```text
Developer Push (QA Branch)
        │
        ▼
GitHub Actions Trigger
        │
        ▼
Gitleaks Secret Scan
        │
        ▼
Checkov Security Scan
 ├── Terraform
 ├── Kubernetes
 └── Docker
        │
        ▼
Trivy Filesystem Scan
 ├── Client
 └── Server
        │
        ▼
Client & Server Lint
        │
        ▼
Client & Server Tests
        │
        ▼
SonarQube Analysis
        │
        ▼
Client Build
        │
        ▼
Multi-stage Docker Build
        │
        ▼
Trivy Image Scan
        │
        ▼
SBOM Generation
        │
        ▼
Push Docker Image
        │
        ▼
Update Kubernetes Manifest
        │
        ▼
Deploy to Amazon EKS
        │
        ▼
Verify Deployment
```

---

# 📷 GitHub Actions Pipeline

The complete CI/CD workflow is implemented using GitHub Actions.

![GitHub Actions Pipeline](docs/screenshots/github-actions-pipeline.png)

---

# 🌿 Branch Strategy

This project follows a simple environment-based branching strategy.

| Branch | Purpose |
|---------|----------|
| **main** | Production Environment |
| **qa** | QA / Staging Environment |

## QA Pipeline

The QA pipeline performs:

- Secret Scanning
- Security Validation
- Linting
- Unit Testing
- SonarQube Analysis
- Docker Build
- Docker Image Scan
- SBOM Generation
- Docker Image Push
- Kubernetes Deployment to QA Cluster

## Production Workflow

A separate production deployment workflow is included for production releases after QA validation.

---

# 🔐 Security Pipeline

## 1. Gitleaks

Scans the Git repository for accidentally committed:

- Secrets
- API Keys
- Tokens
- Passwords
- AWS Credentials

---

## 2. Checkov

Infrastructure as Code (IaC) security scanning for:

- Terraform
- Kubernetes Manifests
- Dockerfile

---

## 3. Trivy Filesystem Scan

Scans the client and server source code for:

- Vulnerabilities
- Misconfigurations
- Security Issues

---

## 4. Linting

Runs linting on both client and server applications.

---

## 5. Automated Testing

Runs application test cases before deployment.

---

## 6. SonarQube

Performs:

- Static Code Analysis
- Bugs Detection
- Code Smells
- Security Hotspots
- Maintainability Analysis

The Quality Gate validates the project before continuing.

---

## 7. Docker Build

A secure **multi-stage Docker build** is used to produce a lightweight production image.

Security best practices include:

- Multi-stage Build
- Alpine Images
- Production Dependencies Only
- Non-root User
- Reduced Attack Surface

---

## 8. Trivy Image Scan

The generated Docker image is scanned before publishing.

Checks include:

- Critical Vulnerabilities
- High Vulnerabilities

---

## 9. Software Bill of Materials (SBOM)

SBOM files are generated for:

- Source Code
- Docker Image

This improves software supply chain transparency.

---

## 10. Docker Hub

Images are published using:

- Commit SHA Tag
- Latest Tag

---

## 11. Kubernetes Manifest Update

The deployment manifest is automatically updated with the latest Docker image tag before deployment.

---

## 12. Amazon EKS Deployment

The application is deployed using:

- GitHub OIDC Authentication
- AWS IAM Role
- kubectl
- Kubernetes Manifests

Deployment verification is automatically performed after rollout.

---

# 🐳 Docker

This project uses a **multi-stage Docker build**.

Highlights:

- Frontend Build Stage
- Backend Runtime Stage
- Production Dependencies
- Non-root User
- Lightweight Alpine Images
- Optimized Image Size

---

# ☸ Kubernetes

Deployment uses the following Kubernetes resources.

- Deployment
- Service
- Ingress

Separate manifests are maintained for:

- QA
- Production

---

# 📂 Repository Structure

```text
.
├── .github/
│   └── workflows/
│       ├── qa-cicd.yml
│       └── prod-cd.yaml
│
├── client/
│
├── server/
│
├── k8-manifests/
│   ├── qa/
│   │   ├── app-deployment.yaml
│   │   ├── app-svc.yaml
│   │   └── app-ingress.yaml
│   │
│   └── prod/
│       ├── app-deployment.yaml
│       ├── app-svc.yaml
│       └── app-ingress.yaml
│
├── docs/
│   ├── architecture.png
│   └── screenshots/
│       ├── github-actions-pipeline.png
│       ├── sonarqube-dashboard.png
│       ├── trivy-report.png
│       └── deployment.png
│
├── Dockerfile
├── sonar-project.properties
├── .gitignore
└── README.md
```

---

# 📸 Screenshots

## GitHub Actions

![GitHub Actions](docs/screenshots/github-actions-pipeline.png)

---

## SonarQube Dashboard

![SonarQube](docs/screenshots/sonarqube-dashboard.png)

---

## Trivy Scan

![Trivy](docs/screenshots/trivy-report.png)

---

## Kubernetes Deployment

![Deployment](docs/screenshots/deployment.png)

---

# 🚧 Current Status

This project was successfully developed and tested as an end-to-end DevSecOps learning project.

The AWS learner account originally used to host the Amazon EKS cluster and related cloud resources has since expired after the available credits were exhausted. As a result, the deployment stage cannot currently be demonstrated.

The repository still contains the complete implementation of:

- GitHub Actions workflows
- Docker configuration
- Kubernetes manifests
- Security scanning
- CI/CD automation
- Deployment logic

---

# 🔮 Future Improvements

- Helm Charts
- ArgoCD GitOps Deployment
- Prometheus Monitoring
- Grafana Dashboards
- Horizontal Pod Autoscaler
- Slack Notifications
- Canary Deployment
- Blue/Green Deployment
- Terraform Infrastructure Provisioning

---

# 👨‍💻 Author

## Gaurav Bhardwaj

**DevOps & Cloud Engineer**

📧 Email: gaurav.bhardwaj4@hotmail.com

🔗 LinkedIn: https://www.linkedin.com/in/YOUR-LINKEDIN

💻 GitHub: https://github.com/Gauravbhardwajdev

---

## ⭐ Support

If you found this project useful, consider giving it a ⭐ on GitHub.
