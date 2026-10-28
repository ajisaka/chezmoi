
import boto3

    s3_resource = boto3.resource('s3')
    objs = s3_resource.Bucket('...').objects.filter(Prefix='...')
    for obj in objs:
        # ObjectSummary - https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/s3.html#objectsummary
        print(obj)
