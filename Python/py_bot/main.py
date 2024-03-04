import boto3

ec2_client = boto3.client('ec2')

response = ec2_client.run_instances(
    ImageId='ami-07d9b9ddc6cd8dd30 ',
    InstanceType='t2.micro',
    MinCount=1,
    MaxCount=1,
    KeyName='Trainee_key_aws',
    SecurityGroupIds=['sg-01e01d940865c8d3d'],
    SubnetId='subnet-02aa0bc1fb438bb35'
)

# Получение идентификатора созданного экземпляра
instance_id = response['Instances'][0]['InstanceId']
print(f'Создан экземпляр с идентификатором: {instance_id}')