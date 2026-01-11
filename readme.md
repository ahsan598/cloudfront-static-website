# AWS Static Website CI/CD Project

### 🎯 Project Overview
This project showcases a complete CI/CD pipeline for deploying a static website on the cloud.  
The website is hosted on **Amazon S3**, distributed globally via **Amazon CloudFront**, and continuously deployed using **Jenkins**.

### 🛠️ Tech Stack
- **CI/CD Automation:** Jenkins  
- **Static Website Hosting:** Amazon S3  
- **Content Delivery Network (CDN):** Amazon CloudFront  
- **Access Management:** AWS IAM  

### 🧩 Architecture Diagram
![Diagram](/assets/diagram.png)


### 📋 Prerequisites
Before you begin, make sure the following tools and services are available:
| Tool        | Purpose                                                     | Documentation |
|-------------|-------------------------------------------------------------|---------------|
| **Jenkins** | Automation server used to manage the CI/CD pipeline         | [Install Jenkins](https://www.jenkins.io/doc/book/installing/)  |
| **AWS Account** | Required to deploy the website using S3 and CloudFront  | [Login AWS](https://aws.amazon.com/)  |


### 🚀 Deploy Static website on S3

**Step-1: Create S3 Bucket**

| **Setting**            | **Value**                       |
| ---------------------- | ------------------------------- |
| Bucket Name            | `barista-cafe-website-<unique>` |
| Region                 | `us-east-1`                     |
| Block Public Access    | ❌ Disabled                     |
| Static Website Hosting | ✅ Enabled                      |
| Index Document         | `index.html`                    |

**Step-2: S3 Bucket Policty:**
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

**Step-3: Create CloudFront Distribution**
- **Origin:** your S3 bucket
- Viewer protocol policy: **Redirect HTTP → HTTPS**
- Default root object: `index.html`
- Wait **~10–15 minutes** for deployment
Copy your **CloudFront Domain Name**.

**Step-4: Jenkins AWS Credentials Setup**

**1. Create IAM User with:**
- `AmazonS3FullAccess`
- `CloudFrontFullAccess`

**2. Add credentials in Jenkins:**
- Type: **AWS Credentials**
- ID: `aws-cred`

**Step-5: Access Website**
```txt
https://YOUR_CLOUDFRONT_DOMAIN
```
![Barsita](/assets/output.png)

### 🧾 Summary
- Hosted a static website on **Amazon S3**
- Delivered content globally using **Amazon CloudFront** with cache invalidation
- Implemented automated CI/CD pipeline using **Jenkins**
- Enabled public access to the website with high availability and low latency worldwide
