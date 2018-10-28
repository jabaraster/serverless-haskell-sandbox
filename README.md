[serverless-haskell](https://github.com/seek-oss/serverless-haskell)を使ってみた.

## serverless-haskellプラグインをインストールする必要がある

```
sls install -n serverless-haskell
```

## node.jsとHaskellのserverless-haskellのバージョンを合わせる

具体的には、stack.yamlのextra-depsにバージョンを明記する.

```yaml
extra-deps:
- serverless-haskell-0.7.5
```

## serverless.ymlのruntimeを"haskell"にしているとデプロイに失敗することがある
[serverless-haskellのexample-project](https://github.com/seek-oss/serverless-haskell/tree/master/example-project)ではruntimeは"haskell"となっているのだが、下記のようなエラーが出てデプロイに失敗するようなことがある.

```
Serverless: Updating Stack...
Serverless: Checking Stack update progress...
......
Serverless: Operation failed!
 
  Serverless Error ---------------------------------------
 
  An error occurred: ApigwLambdaFunction - Value haskell at 'runtime' failed to satisfy constraint: Member must satisfy enum value set: [java8, nodejs6.10, nodejs8.10, python2.7, python3.6, dotnetcore1.0, dotnetcore2.0, dotnetcore2.1, go1.x] or be a valid ARN (Service: AWSLambda; Status Code: 400; Error Code: InvalidParameterValueException; Request ID: ca41eb1c-da4b-11e8-ab75-b723d4f70500).

```

うまく行くこともあり原因は掴めていないが、serverless.ymlのruntimeを"nodejs8.10"として対処した.
