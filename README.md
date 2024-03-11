# Check out my personal site at [sichello.com](http://sichello.com) 

## About This Site

This website is a project I used to learn more about Terraform and serverless design in AWS. Prior to this I had never used Terraform and had always just manually deployed any cloud resources I needed. I had also never built a fully serverless application in AWS so I had learned along the way.

As you can see from the architecture diagram below, there's a suprising amount going on under the hood. The entire site is hosted for $0/month in AWS and is completely serverless with high speed and availability from Cloudfront CDN. In order to provide the visitor counter you see down in the footer of the page, the implementation also includes a serverless API that is backed by Lambda and DynamoDB. Best of all, by using Terraform for IaC, the site content and all underlying AWS infrastructure can be modified, tested, and deployed in seconds via a push to my GitHub repo for CI/CD.

![Site Architecture](/src/assets//img/architecture.png)


Couldn't I have just deployed a static resume more quickly using GitHub pages, you ask? Yes, I could have. Is my site completely overengineered for the task? Absolutely, but that's the whole point! It's a small scale implementation of what you'd see in a larger scale web application. Here's how it works:

1. User requests to load sichello.com in their browser.
1. DNS request is sent to Route53, which resolves to the nearest Cloudfront CDN edge location.
1. Cloudfront forwards the request to an S3 bucket containing the the frontend files and they are return to the browser.
1. The S3 bucket with frontend code is protected with Origin Access Identity (OAI), which prevents direct access to the bucket.
1. JavaScript in the frontend sends a POST request to an API Gateway to retrieve the number of visitors for the footer.
1. The API Gateway, protected by Cross Origin Resource Sharing (CORS), forwards the POST request to a Lambda function.
1. The Lambda function, written in Python, increments the visitor counter in the DynamoDB and returns the count.
1. The visitor count is displayed in the footer.
1. A Github repo provides code version control and CI/CD through a Github Actions intergration with Terraform.
1. Terraform deploys the AWS infrastructure.

The project was not without its struggles, but that's usually where the learning happens for me. I started off by making a very basic HTML site then manually creating and integrating all the AWS componenents as a proof of concept. Once that had been fleshed out I looped back on the IaC and implemented the nearly thirty underlying AWS site resources in Terraform code- no a small undertaking. Getting the CloudFront configs, Lambda function, CORS rules and routing implemented in Terraform took the majority of the project time.

Once I had the site to the point that I could completely destroy all AWS resources, then redeploy them all with click, I took some more time to make the HTML/CSS pretty and update up my resume. If you have any questions about it, shoot me an email, I'd love to chat.
