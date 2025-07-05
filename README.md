![image](https://github.com/user-attachments/assets/a4042ef7-2a52-4b91-a212-1e9b3a8e6063)

# ITGenius CI/CD Pipeline - Deployment of Monolithic Application

This project outlines a robust CI/CD pipeline designed to deploy the ITGenius application as a JAR file to a monolithic server. The pipeline ensures seamless code integration, thorough quality checks, artifact management, and automated deployment for front-end users to access via an AWS Route 53 record set. Below is an explanation of the pipeline flow and tools involved:

---

## **Project Workflow Overview**

### 1. **Developer Interaction**

- **Developers** write and push their code to a GitHub repository using `Git Push`.
- They can also pull updates from the repository (`Git Pull`) to synchronize with the latest changes made by their team.

### 2. **GitHub Repository**

- The GitHub repository acts as the central codebase where all changes are stored.
- Jenkins fetches the latest code from this repository to build, test, and deploy the application.

### 3. **Jenkins - CI/CD Orchestrator**

- **Code Retrieval:** Jenkins automatically triggers the CI/CD pipeline whenever changes are pushed to the GitHub repository.
- **Build Process:**
  - Jenkins builds the Java application into a deployable JAR file.
  - Runs unit tests and performs static code analysis.
- **Error Notifications:**
  - If there are issues during the build or testing stages, Jenkins alerts developers to fix and resubmit their changes.

### 4. **Infrastructure as Code (IaC)**

- Tools like **Terraform** and **Ansible** handle infrastructure provisioning and configuration management:
  - **Terraform:** Automates the creation and management of infrastructure components, such as IAM roles and database resources.
  - **Ansible:** Configures all servers including monolithic server to ensure it is ready to run the JAR file.

### 5. **Artifact Management**

- The generated JAR file is stored and versioned in the **Nexus Repository** for secure artifact management.
- This ensures that only approved builds are deployed to the server.

### 6. **Monolithic Server Deployment**

- The JAR file is deployed directly to the **Monolithic Server**.
- **AWS Secrets Manager** and **AWS IAM:**
  - Securely store and retrieve sensitive credentials (e.g., database passwords) used by the monolithic application.
  - IAM roles control access to the server and other AWS resources.

### 7. **Database Integration**

- The monolithic application connects to an **RDS MySQL Cluster** for its database needs.
- AWS IAM provides secure authentication for the application to access the database.

### 8. **Frontend Access**

- End-users access the application through a domain name configured in **AWS Route 53**. The domain for the application is `www.itgenius-training.io`.

---

## **Tools Involved**

- **GitHub:** Source code repository.
- **Jenkins:** CI/CD pipeline orchestration.
- **Terraform and Ansible:** Infrastructure provisioning and server configuration.
- **Nexus Repository:** Artifact storage and versioning for JAR files.
- **SonarQube:** Static code analysis for quality assurance.
- **Prometheus and Grafana:** Application performance monitoring and visualization.
- **AWS (IAM, Secrets Manager, RDS, Route 53):** Cloud services for security, database, and DNS management.

---

## **How to Get Started**

To participate in or replicate this project setup, follow our detailed guide available on the Confluence page: [ITGenius Confluence](https://itgenius-team-u5ijt9rh.atlassian.net/wiki/spaces/documentat/folder/82378767?atlOrigin=eyJpIjoiNjg5MzZhOWJmNGQ3NDk4MDg3MDk3N2ZkMjg5NDA3ZGYiLCJwIjoiYyJ9).

This guide includes step-by-step instructions for setting up the pipeline, configuring the tools, and deploying the application.
