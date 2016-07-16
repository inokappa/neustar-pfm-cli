# neustar-pfm-cli
[![Build Status](https://travis-ci.org/inokappa/neustar-pfm-cli.svg?branch=master)](https://travis-ci.org/inokappa/neustar-pfm-cli)

## About

- Neustar WebPerformance Management API を叩く非公認コマンドラインツール
- 負荷試験シナリオスクリプトのアップロード、Local Validate 等を行うことが出来る
- 負荷試験のスケジュール等を行うことが出来る

## Reference

- https://apidocs.wpm.neustar.biz/loadtesting
- https://apidocs.wpm.neustar.biz/script

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'neustar_pfm_cli'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install neustar_pfm_cli

## Usage

### 環境変数

- API キー及び、Shared Secret

```sh
export NEUSTAR_API_KEY="xxxxxxxxxxxxxxxxxxxxxxxxxx"
export NEUSTAR_SHARED_KEY="xxxxxxx"
```

- Local Validator

```sh
export NEUSTAR_LOCAL_VALIDATOR_PATH="/path/to/local-validator-4.34.17/bin/validator"
```

### loadtest

- ls ... 負荷試験一覧を取得する

```sh
bundle exec bin/npc-loadtest ls | jq '.data.items[]'
```

- get ... 負荷試験の詳細を取得する

```sh
bundle exec bin/npc-loadtest get -i 123456 | jq '.data.items[]'
```

- del ... 指定した負荷試験を削除する

```sh
bundle exec bin/npc-loadtest del -i $(bundle exec bin/npc-loadtest ls | jq '.data.items[].id')
```

- sc ... 指定した負荷試験をスケジュールする

```sh
bundle exec bin/npc-loadtest sc -f loadtest.yml
```

loadtest.yml は以下のように定義する。

```yaml
name: "myloadtest"
region: "AP_NORTHEAST"
scripts:
  - percentage: 100
      scriptId: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
      parts:
  - duration: 5
      maxUsers: 10
      type: "RAMP"
```

### scripting

- ls ... 負荷試験シナリオスクリプト一覧を取得する

```sh
bundle exec bin/npc-scripting ls | jq '.data.items[]'
```

- val ... 指定した負荷試験シナリオスクリプトを Local Validator を利用してチェックする

```sh
bundle exec bin/npc-scripting val -f path/to/script.js
```
- up ... 指定した負荷試験シナリオスクリプトをアップロードする

```sh
bundle exec bin/npc-scripting up -n script_name -f path/to/script.js -t tag1,tag2 -d description
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/neustar_pfm_cli.

