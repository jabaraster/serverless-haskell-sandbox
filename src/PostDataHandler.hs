{-# LANGUAGE OverloadedStrings #-}
module PostDataHandler where

import           Control.Lens
import           Data.HashMap.Strict  as M
import           Data.Semigroup
import           Data.Text            (Text, pack)
import qualified Data.UUID            as UUID
import           Data.UUID.V4
import           System.Environment

import           Network.AWS.DynamoDB

import           AWSLib
import           Types

core :: CreateDataRequest -> IO (Either Text DynamoDbRecord)
core req = do
  uuid <- nextRandom
  let item = M.fromList [
               ("id", attributeValue&avS .~ Just (UUID.toText uuid))
             , ("name", attributeValue&avS .~ Just (cdrName req))
             ]
  env <- awsEnv
  tableName <- getEnv "FIRST_TABLE" >>= return . pack

  res <- runPutItem env $ (putItem tableName)&piItem .~ item
  case res^.pirsResponseStatus of
    200 ->
      return $ Right
         $ DynamoDbRecord {
             ddrId = UUID.toString uuid
           , ddrName = cdrName req
           }
    s   -> return $ Left $ "Response status is invalid -> " <> (pack $ show s)
