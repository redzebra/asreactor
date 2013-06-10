# Auto Scaling Reactor

React to EC2 Auto Scaling activities.

[![Build Status](https://travis-ci.org/redzebra/asreactor.png?branch=master)](https://travis-ci.org/redzebra/asreactor)
[![Coverage Status](https://coveralls.io/repos/redzebra/asreactor/badge.png?branch=master)](https://coveralls.io/r/redzebra/asreactor?branch=master)
[![Dependency Status](https://gemnasium.com/redzebra/asreactor.png)](https://gemnasium.com/redzebra/asreactor)

## Installation

```shell
gem install asreactor
```
or add the following line to Gemfile:

```ruby
gem 'asreactor'
```
and run `bundle install` from your shell.

## Configuration

_TODO_

## Reacting to Events

_TODO_

Details of the triggering Auto Scaling activity are passed in the environment.

```shell
ASREACT_ACCOUNT_ID
ASREACT_ACTIVITY_ID
ASREACT_AUTO_SCALING_GROUP_ARN
ASREACT_AUTO_SCALING_GROUP_NAME
ASREACT_CAUSE
ASREACT_DESCRIPTION
ASREACT_DETAILS
ASREACT_EC2_INSTANCE_ID
ASREACT_END_TIME
ASREACT_EVENT
ASREACT_PROGRESS
ASREACT_REQUEST_ID
ASREACT_SERVICE
ASREACT_START_TIME
ASREACT_STATUS_CODE
ASREACT_STATUS_MESSAGE
ASREACT_TIME

ASREACT_REGION
```

## Credentials and Permissions

Set AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, and AWS_REGION in the environment before running asreactor. (TODO: support credentials in the configuration file.) Instance profiles are supported as an alternative.

asreactor requires the following IAM permissions:

  - sns:Subscribe
  - sns:Unsubscribe
  - sqs:CreateQueue
  - sqs:DeleteMessage
  - sqs:DeleteQueue
  - sqs:GetQueueAttributes
  - sqs:ReceiveMessage
  - sqs:SetQueueAttributes

**This list is probably incomplete and is likely to change.**

## AWS Costs

**asreactor will incur costs in Amazon Web Services and you use it at your own
risk.** The costs will normally be negligible but this software may contain
bugs which result in runaway SQS use.

See [Amazon SQS Pricing][Amazon SQS Pricing] for further details of costs.

## License

This software is distributed under the
[Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0).

```no-highlight
Copyright 2013 Nick Osborn.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

[Amazon SQS Pricing]: http://aws.amazon.com/sqs/#pricing
