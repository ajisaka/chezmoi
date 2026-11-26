    paginator = client.get_paginator('describe_log_groups')

    for page in paginator.paginate():
        print(page)
