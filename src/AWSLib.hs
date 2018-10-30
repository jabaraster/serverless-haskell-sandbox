{-# LANGUAGE OverloadedStrings #-}
module AWSLib where

import           Control.Lens
import           Data.Text                  (Text, pack)

import           Network.AWS
import           Network.AWS.DynamoDB
import           Network.AWS.DynamoDB.Types
import           System.Environment

awsEnv :: IO Env
awsEnv = do
    putStrLn "------- Try creation new env."
    getEnv "AWS_ACCESS_KEY_ID" >>= putStrLn
    getEnv "AWS_SECRET_ACCESS_KEY" >>= putStrLn
    e <- newEnv $ FromEnv "AWS_ACCESS_KEY_ID" "AWS_SECRET_ACCESS_KEY" Nothing Nothing
    putStrLn "------- env created."
    pure $ e&envRegion .~ Tokyo

runScan :: Env -> String -> IO ScanResponse
runScan env tableName = run env $ scan $ pack tableName

runPutItem :: Env -> PutItem -> IO PutItemResponse
runPutItem env putItem = run env putItem

run env = runResourceT . runAWS env . send
