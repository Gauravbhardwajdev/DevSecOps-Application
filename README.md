# Enterprise DevSecOps CI/CD Pipeline using GitHub Actions, Docker, Kubernetes & AWS EKS

## Overview

This project demonstrates an end-to-end Enterprise DevSecOps CI/CD pipeline built using GitHub Actions. The pipeline follows security-first DevOps practices by integrating automated security scanning, code quality analysis, container security, Software Bill of Materials (SBOM) generation, Docker image publishing, and automated deployment to Amazon EKS.

The objective of this project is to simulate a production-grade DevSecOps workflow where every code change is automatically validated, scanned, containerized, and deployed to Kubernetes.

---

## Architecture

Developer Push (QA Branch)

↓

GitHub Actions Trigger

↓

Gitleaks Secret Scan

↓

Checkov Security Scans

* Terraform
* Kubernetes
* Docker

↓

Trivy Filesystem Scan

* Client
* Server

↓

Linting

* Client
* Server

↓

Automated Testing

↓

SonarQube Code Quality Analysis

↓

Client Build

↓

Multi-stage Docker Build

↓

Trivy Docker Image Scan

↓

SBOM Generation

↓

Docker Hub Image Push

↓

Update Kubernetes Deployment Manifest

↓

Deploy to Amazon EKS

↓

Verify Kubernetes Rollout

---

## Technologies Used

### Cloud

* Amazon Web Services (AWS)
* Amazon Elastic Kubernetes Service (EKS)

### CI/CD

* GitHub Actions

### Containerization

* Docker
* Multi-stage Docker Builds

### Container Orchestration

* Kubernetes

### Security

* Gitleaks
* Checkov
* Trivy
* SonarQube

### Infrastructure

* Kubernetes Manifests

### Container Registry

* Docker Hub

### Authentication

* GitHub OIDC
* AWS IAM Role

---

## Pipeline Stages

### 1. Secret Scanning

The pipeline starts by scanning the repository using Gitleaks to identify accidentally committed secrets such as API keys, passwords, or tokens.

---

### 2. Infrastructure Security

Checkov validates Infrastructure-as-Code configurations by scanning:

* Terraform
* Kubernetes manifests
* Docker configurations

---

### 3. Filesystem Vulnerability Scanning

Trivy scans both the client and server directories for known vulnerabilities before the application is built.

---

### 4. Code Quality

The pipeline performs:

* Client linting
* Server linting
* Unit tests
* SonarQube static code analysis
* SonarQube Quality Gate validation

---

### 5. Docker Build

A secure multi-stage Docker image is built to reduce image size and separate the build environment from the runtime environment.

The final image runs as a non-root user following the Principle of Least Privilege.

---

### 6. Container Security

The built Docker image is scanned using Trivy to identify vulnerabilities before publishing.

---

### 7. Software Bill of Materials (SBOM)

SBOM files are generated for both the application source and Docker image to improve software supply chain visibility.

---

### 8. Docker Hub Push

After all quality and security checks pass, the Docker image is pushed to Docker Hub using immutable commit SHA tags and the latest tag.

---

### 9. Kubernetes Deployment

The deployment manifest is automatically updated with the newly generated Docker image tag.

GitHub Actions commits the updated manifest back to the QA branch.

---

### 10. Amazon EKS Deployment

GitHub Actions authenticates with AWS using OpenID Connect (OIDC), generates the Kubernetes configuration, applies the Kubernetes manifests, and verifies the deployment rollout.

---

## Security Features

* Secret Detection using Gitleaks
* Infrastructure Security using Checkov
* Static Code Analysis using SonarQube
* Filesystem Vulnerability Scanning using Trivy
* Container Image Vulnerability Scanning
* SBOM Generation
* Non-root Docker Container
* OIDC Authentication for AWS
* Automated Quality Gates

---

## Docker Features

* Multi-stage build
* Lightweight Alpine Linux images
* Production-only dependencies
* Non-root container execution
* Optimized image size

---

## Kubernetes Resources

* Deployment
* Service
* Ingress

---

## Future Improvements

* Helm Chart deployment
* ArgoCD GitOps integration
* Prometheus monitoring
* Grafana dashboards
* Horizontal Pod Autoscaler
* Canary deployments
* Slack or Microsoft Teams notifications

---

## Author

**Gaurav Bhardwaj**

DevOps & Cloud Engineer
