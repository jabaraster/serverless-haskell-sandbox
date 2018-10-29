{-# LANGUAGE OverloadedStrings #-}
module AWSLib where

import           Control.Lens
import           Data.Text                  (Text, pack)

import           Network.AWS
import           Network.AWS.DynamoDB
import           Network.AWS.DynamoDB.Types

awsEnv :: IO Env
awsEnv = do
    -- e <- newEnv $ FromEnv "AWS_ACCESS_KEY" "AWS_SECRET_ACCESS_KEY" Nothing Nothing
    putStrLn "Try creation env."
    e <- newEnv Discover
    pure $ e&envRegion .~ Tokyo

runScan :: Env -> String -> IO ScanResponse
runScan env tableName = run env $ scan $ pack tableName

runPutItem :: Env -> PutItem -> IO PutItemResponse
runPutItem env putItem = run env putItem

run env = runResourceT . runAWS env . send
