# ☕ Barista Cafe - DevOps Deployment Project

This project demonstrates a complete CI/CD pipeline using:
- Jenkins
- Docker
- Nginx

The Barista Cafe template is a static website served using Nginx inside a Docker container.


### 🧩 Architecture Diagram

![Diagram](/assets/jenkins-deploy-static-site.png)


### 🐳 Run locally using Docker

**Step-1: Build Image**
```sh
docker build -t barista .
```

**Step-2: Run as a Container**
```sh
docker run -dp 80:80 --name barista-app barista
```

**Step-3: Access in Browser**
```txt
http://localhost:80
```
![Barsita]()


### ⚙️ Jenkins Pipeline Steps
- Clone repository
- Build Docker image
- Push image to Docker Hub
- Deploy website using Docker container
- Clean old images

### ## ☁️ AWS Deployment

This website is deployed using:
- Amazon S3 (Static Website Hosting)
- Amazon CloudFront (CDN)
- Jenkins CI/CD Pipeline

### Deployment Flow

GitHub → Jenkins → S3 → CloudFront → Public Access

### Website URL
```txt
https://YOUR_CLOUDFRONT_DOMAIN
```

---

### Create S3 Bucket

| Setting                | Value                           |
| ---------------------- | ------------------------------- |
| Bucket Name            | `barista-cafe-website-<unique>` |
| Region                 | us-east-1 (recommended)         |
| Block Public Access    | ❌ Off                          |
| Static Website Hosting | ✅ Enable                       |
| Index Document         | `index.html`                    |

**Bucket Policty:**
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


### Create CloudFront Distribution

- Origin: your S3 bucket
- Viewer protocol policy: Redirect HTTP → HTTPS
- Default root object: index.html
- Wait 10–15 minutes for deployment

**Copy the CloudFront Domain Name.**


### Jenkins AWS Credentials Setup

**1. Create IAM User:**
- **Permissions:**
  - `AmazonS3FullAccess`
  - `CloudFrontFullAccess`
**2. Add to Jenkins:**
- Credentials → AWS Credentials
- ID: `aws-cred`