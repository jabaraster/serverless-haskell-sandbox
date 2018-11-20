{-# LANGUAGE OverloadedStrings #-}
module GetDataHandler where

import           Control.Lens
import           Data.HashMap.Strict  (HashMap, lookup)
import           Data.Maybe
import           Data.Text            (Text, unpack)
import           Prelude              hiding (lookup)
import           System.Environment

import           Network.AWS
import           Network.AWS.DynamoDB

import           AWSLib
import           Types

core :: IO (Maybe [DynamoDbRecord])
core = do
  env <- awsEnv
  tableName <- getEnv "FIRST_TABLE"

  putStrLn "Get env. next ---> execute scan."

  res <- runScan env tableName
  putStrLn "Scanned!"

  case res^.srsResponseStatus of
    200 -> return $ Just $ map cnv $ res^.srsItems
    _   -> return Nothing
  where
    -- cnv2 :: HashMap Text AttributeValue -> DynamoDbRecord
    -- cnv2 rec = let id = rec ^? key "id" . key "S" . _String
    --                nm = rec ^? key "name" . key "S" . _String
    --            in  DynamoDbRecord {
    --                  ddrId = id
    --                , ddrName = nm
    --                }
    cnv :: HashMap Text AttributeValue -> DynamoDbRecord
    cnv rec = let id = lookup "id" rec
                         >>= \v -> v^.avS
                  nm = lookup "name" rec
                         >>= \v -> v^.avS
              in
                DynamoDbRecord {
                  ddrId = unpack $ fromMaybe "" id
                , ddrName = fromMaybe "" nm
                }
