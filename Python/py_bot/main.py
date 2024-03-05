import time
import boto3
import paramiko


def create_instance():
    ec2_client = boto3.client('ec2')

    response = ec2_client.run_instances(
        ImageId='ami-0cd59ecaf368e5ccf',
        InstanceType='t2.micro',
        MinCount=1,
        MaxCount=1,
        KeyName='Trainee_key_aws',
        SecurityGroupIds=['sg-01e01d940865c8d3d'],
        SubnetId='subnet-02aa0bc1fb438bb35',
        TagSpecifications=[
            {
                'ResourceType': 'instance',
                'Tags': [
                    {
                        'Key': 'Name',
                        'Value': 'MyInstance'
                    },
                ]
            },
        ]
    )

    instance_id = response['Instances'][0]['InstanceId']
    print(f'Instance created with ID: {instance_id}')

    return instance_id


def get_instance_info(instance_id):
    ec2_resource = boto3.resource('ec2')
    instance = ec2_resource.Instance(instance_id)

    instance.wait_until_running()
    instance.load()

    ip_address = instance.public_ip_address
    os = instance.platform or instance.image_id
    metrics = instance.monitoring['State']
    size = instance.instance_type
    instance_type = instance.instance_type

    print(f'IP_address: {ip_address}')
    print(f'OS: {os}')
    print(f'Metrics: {metrics}')
    print(f'Size: {size}')
    print(f'Type: {instance_type}')

    return ip_address


def change_instance_key(instance_id):
    ec2_resource = boto3.resource('ec2')
    instance = ec2_resource.Instance(instance_id)

    ip_address = instance.public_ip_address
    username = 'ubuntu'
    private_key_path = '/home/artem/Documents/Trainee_key_aws.pem'

    new_public_key_path = '/home/artem/Documents/test_keys/new_key.pub'
    with open(new_public_key_path, 'r') as file:
        new_public_key = file.read().strip()

    new_key_pair_name = 'new_key'

    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    private_key = paramiko.RSAKey.from_private_key_file(private_key_path)
    time.sleep(15)
    client.connect(hostname=ip_address, username=username, pkey=private_key)
    stdin, stdout, stderr = client.exec_command("ls ~/.ssh/", get_pty=True)

    output = stdout.read().decode()
    print(output)

    command = f"echo '{new_public_key}' >> ~/.ssh/authorized_keys"
    stdin, stdout, stderr = client.exec_command(command)

    client.close()
    print(f'Instance access key {instance_id} add to {new_key_pair_name}')


def ssh_connect_with_retry(ssh, ip_address, retries):
    if retries > 3:
        return False
    privkey = paramiko.RSAKey.from_private_key_file(
        '/home/artem/Documents/test_keys/new_key.pem')
    interval = 5
    try:
        retries += 1
        ssh.connect(hostname=ip_address,
                    username='ubuntu', pkey=privkey)
        return True
    except Exception as e:
        #print(e)
        time.sleep(interval)
        ssh_connect_with_retry(ssh, ip_address, retries)


def test_ssh_connection(ip_address):

    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    try:
        ssh_connect_with_retry(ssh, ip_address, 0)
        print('SSH connection successful')
    except paramiko.AuthenticationException:
        print('Authentication Error')
    except paramiko.SSHException as e:
        print(f'Connection error: {str(e)}')
    finally:
        ssh.close()


def terminate_instance(instance_id):
    ec2_client = boto3.client('ec2')

    response = ec2_client.terminate_instances(
        InstanceIds=[instance_id]
    )

    print('Instance deleted')


instance_id = create_instance()
ip_address = get_instance_info(instance_id)
change_instance_key(instance_id)
test_ssh_connection(ip_address)
terminate_instance(instance_id)