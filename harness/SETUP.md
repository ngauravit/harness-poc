# Harness Terraform POC — Setup Checklist

## 1. Push this repo to Git
Harness pulls Terraform config from Git, not your local disk.
```
git init
git add .
git commit -m "Terraform + Harness POC"
git remote add origin <your-repo-url>
git push -u origin main
```

## 2. Create the remote state backend (one-time, from local)
```
aws s3 mb s3://REPLACE-my-tf-state-bucket --region us-east-1
aws dynamodb create-table --table-name tf-state-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST --region us-east-1
```
Then update the bucket name in `terraform/providers.tf` and run:
```
cd terraform
terraform init -migrate-state   # moves your existing local state to S3
```

## 3. Harness setup (in the Harness UI)
1. **Install a Delegate** — Project Setup → Delegates → New Delegate (Docker is
   easiest for a POC). The delegate must have `terraform` installed, or use a
   delegate image with Terraform baked in / an INIT script to install it.
2. **AWS credentials** — either:
   - Attach an IAM role to the delegate host (recommended), or
   - Add AWS access keys as Harness secrets and export them via the delegate.
3. **Git Connector** — Project Setup → Connectors → GitHub/GitLab/Bitbucket,
   pointing at the repo from step 1.
4. **Create the pipeline** — Pipelines → New Pipeline → switch to YAML view →
   paste `harness/pipeline-terraform-aws.yaml`, replacing:
   - `REPLACE_PROJECT_ID`
   - `REPLACE_GIT_CONNECTOR`
   - `REPLACE_REPO_NAME`

## 4. Run it
Execute the pipeline: Plan runs → you approve → Apply runs with the exact
reviewed plan. Add a `TerraformDestroy` step in a separate pipeline for
teardown when the POC is done.
