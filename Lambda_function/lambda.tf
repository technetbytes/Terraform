# # lambda.tf
# resource "aws_lambda_function" "example_lambda" {
#   filename         = "function.zip"  # Path to the ZIP file containing the Lambda code
#   function_name    = "example_lambda"  # Name of the Lambda function
#   role             = aws_iam_role.lambda_role.arn  # Role ARN
#   handler          = "lambda_function.lambda_handler"  # The function name to execute
#   runtime          = "python3.8"  # Lambda runtime (Python 3.8 in this case)
#   source_code_hash = filebase64sha256("function.zip")  # Base64 hash of the ZIP file to detect changes

#   environment {
#     variables = {
#       EXAMPLE_VAR = "example_value"
#     }
#   }
# }

/* 
Arquive the script
*/
data "archive_file" "python_lambda_package" {
  type = "zip"
  source_file = "${path.module}/function.py"
  output_path = "function.zip"
}

/*
  Create the lamda function
*/
resource "aws_lambda_function" "test_lambda_function" {
    function_name = "lambdaTest"
    
    filename      = "function.zip"
    source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
    role          = aws_iam_role.lambda_role.arn
    runtime       = "python3.8"
    handler       = "lambda_function.lambda_handler"
    timeout       = 10
}