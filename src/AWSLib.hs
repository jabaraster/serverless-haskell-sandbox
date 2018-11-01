{-# LANGUAGE OverloadedStrings #-}
module AWSLib where

import           Control.Lens
import           Data.Text                  (Text, pack)
import Data.Monoid

import           Network.AWS
import           Network.AWS.Env
import           Network.AWS.DynamoDB
import           Network.AWS.DynamoDB.Types
import           System.Environment

awsEnv :: IO Env
awsEnv = do
    e <- newEnv $ FromEnv "AWS_ACCESS_KEY_ID" "AWS_SECRET_ACCESS_KEY" (Just "AWS_SESSION_TOKEN") Nothing
    print $ (_svcEndpoint dynamoDB) Tokyo
    pure $ e {
      _envRegion = Tokyo
    , _envOverride = override
    }
  where
    override :: Dual (Endo Service)
    override = Dual $ Endo service

    service :: Service -> Service
    service svc = svc { _svcEndpoint = endpoint }

    endpoint :: Region -> Endpoint
    endpoint _ = Endpoint {
                   _endpointHost = "dynamodb.ap-northeast-1.amazonaws.com"
                 , _endpointSecure = True
                 , _endpointPort = 443
                 , _endpointScope = "ap-northeast-1"
                 }

runScan :: Env -> String -> IO ScanResponse
runScan env tableName = run env $ scan $ pack tableName

runPutItem :: Env -> PutItem -> IO PutItemResponse
runPutItem env putItem = run env putItem

run env = runResourceT . runAWS env . send
