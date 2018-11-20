{-# LANGUAGE OverloadedStrings #-}
module AWSLib where

import qualified Control.Exception          as E (SomeException, handle)
import           Control.Lens
import           Data.Monoid
import           Data.Text                  (Text, pack)
import           System.Environment

import           Network.AWS
import           Network.AWS.DynamoDB
import           Network.AWS.DynamoDB.Types
import           Network.AWS.Env
import           Network.AWS.S3

awsEnv :: IO Env
awsEnv = do

--    printEnv "AWS_ACCESS_KEY_ID"
--    printEnv "AWS_SECRET_ACCESS_KEY"
--    printEnv "AWS_SESSION_TOKEN"

    e <- newEnv $ FromEnv "AWS_ACCESS_KEY_ID" "AWS_SECRET_ACCESS_KEY" (Just "AWS_SESSION_TOKEN") Nothing
    pure $ e {
      _envRegion = Tokyo
    -- , _envOverride = override
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

runListBuckets :: Env -> IO ListBucketsResponse
runListBuckets env = run env $ listBuckets

runPutItem :: Env -> PutItem -> IO PutItemResponse
runPutItem env putItem = run env putItem

run env = runResourceT . runAWS env . send

printEnv :: String -> IO ()
printEnv s = E.handle (err s) $ do
               e <- getEnv s
               putStrLn $ s ++ ": " ++ e
  where
    err :: String -> E.SomeException -> IO ()
    err s e = putStrLn $ s ++ ": " ++ (show e)
