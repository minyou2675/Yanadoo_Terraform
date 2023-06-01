module "seoul"{
    source = "./seoul"
    provider {
        aws = "aws.ap-northeast-2"
    }
}

module "japan"{
    source = "./japan"
    provider {
        aws = "aws.ap-northeast-1"
    }
}

module "virginia"{
    source = "./virginia"
    provider {
        aws = "aws.us-east-1"
    }
}