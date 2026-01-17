# Barista Static Website with AWS S3, CloudFront & Jenkins CI/CD

### 🎯 Project Overview
This project demonstrates the automated deployment of a **static Barista website** using AWS services and **Jenkins CI/CD**. The website is hosted on **Amazon S3**, delivered via **CloudFront CDN**, and automatically updated through a Jenkins pipeline whenever new changes are pushed to **GitHub**.

**Tech Stack**
- **AWS S3** – Static Hosting  
- **AWS CloudFront** – CDN & HTTPS  
- **Jenkins** – CI/CD Automation  
- **Git/GitHub** – Version Control  
- **HTML, CSS, JavaScript** – Frontend


### 🧩 Architecture Diagram
![Diagram](./assets/diagram.png)


### 📋 Prerequisites

| Tool        | Purpose                          | Documentation |
|-------------|----------------------------------|---------------|
| **Jenkins** | CI/CD automation server          | [Install Jenkins](https://www.jenkins.io/doc/book/installing/)  |
| **AWS Account** | Required for S3 & CloudFront | [AWS Console](https://aws.amazon.com/)  |


### 🚀 Deploying Static website on S3

**Step-1: Create S3 Bucket**

| **Setting**            | **Value**                       |
| ---------------------- | ------------------------------- |
| Bucket Name            | `barista-cafe-website-<unique>` |
| Region                 | `us-east-1`                     |
| Block Public Access    | ❌ Disabled                     |
| Static Website Hosting | ✅ Enabled                      |
| Index Document         | `index.html`                    |

**Step-2: Apply S3 Bucket Policty:**
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::YOUR_BUCKET_NAME/*"
    }
  ]
}
```

![S3 Bucket](./assets/s3-bucket.png)

**Step-3: Create CloudFront Distribution**
- Go to **CloudFront → Create distribution**
- Choose plan: **Free**
- Distribution name: `barista-cafe-website`
- Origin: Your **S3 bucket**
- Create distribution and wait **~3–5 minutes**

Copy your **CloudFront ID**.

![CloudFront](./assets/cdn.png)


**Step-4: Jenkins AWS Credentials Setup**

**1. Create IAM User with access key**
- Go to **IAM → Users → Create user**
- User name: `jenkins-user`
- Select Programmatic access: `CLI`
- Attach permissions:
  - `AmazonS3FullAccess`
  - `CloudFrontFullAccess`
- Create user and download **Access Key & Secret**

**2. Configure Jenkins Credentials**

Jenkins → Manage Jenkins → **Credentials → Add Credentials**
| Field      | Value               |
| ---------- | ------------------- |
| Kind       | **AWS Credentials** |
| ID         | `aws-cred`          |
| Access Key | **From IAM**        |
| Secret Key | **From IAM**        |

![Jenkins-IAM](./assets/jenkins-user.png)

**Step-5: Access Website**
```txt
https://YOUR_CLOUDFRONT_DOMAIN
```
![Barsita](./assets/output.png)


### 🧹 Cleanup Resources (Important)

**To avoid AWS charges:**

**1. Delete CloudFront Distribution:**
  CloudFront → Select distribution → Disable → Delete

**2. Delete S3 Bucket:**
  S3 → Empty bucket → Delete bucket

**3. Delete IAM User:**
  IAM → Users → Delete jenkins-user


### 🧾 Summary
- Hosted a static website on **Amazon S3**
- Delivered content globally using **Amazon CloudFront** with cache invalidation
- Implemented automated CI/CD pipeline using **Jenkins**
- Enabled public access to the website with high availability and low latency worldwide
