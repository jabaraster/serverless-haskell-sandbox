{-# LANGUAGE OverloadedStrings #-}
module S3Handler where

import           Control.Lens
import           Data.Text                  (Text)
import           Network.HTTP.Simple

import qualified Data.ByteString.Lazy.Char8 as LBSC (putStrLn)
import           Network.AWS.Data.Text
import           Network.AWS.S3

import           AWSLib

core :: IO ([Text])
core = do
    httpRes <- httpLbs "https://httpbin.org/ip"

    LBSC.putStrLn $ getResponseBody httpRes

    env <- awsEnv
    putStrLn "Get env. ---> next listBuckets"
    res <- runListBuckets env
    mapM_ (print . cnv) $ res^.lbrsBuckets
    pure $ map cnv $ res^.lbrsBuckets
  where
    cnv :: Bucket -> Text
    cnv b = toText $ b^.bName
