{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
module Types where

import           Data.Aeson
import qualified Data.ByteString.Lazy.Char8 as BS (pack)
import qualified Data.HashMap.Strict        as H
import qualified Data.Text                  as T (intercalate, pack, unpack)
import           GHC.Generics

import           Network.AWS.Data.Text

import           Lib

{-|
 - handlerの型宣言をより自然にするための仕掛け.
 -}
instance ToText () where
    toText _ = ""
instance FromText () where
    parser = return ()

instance ToText (String, String) where
    toText (f, s) = "{\"" <> (T.pack f) <> "\": \"" <> (T.pack s) <> "\"}"
instance ToText [(String, String)] where
    toText ts = "[" <> (T.intercalate "," $ map toText ts) <> "]"

{-|
 - HTTPリクエストの情報を格納する.
 -}
type Headers = [(Text, Text)]

data HttpInfo = HttpInfo {
    pathParameters      :: H.HashMap Text Text
  , headers             :: [(Text, Text)]
  , environments        :: [(String, String)]
  , securityCredentials :: Text
  , files               :: [String]
} deriving (Generic, Show)

instance ToJSON HttpInfo
instance ToText HttpInfo where
    toText = jsonToText

{-|
 - DynamoDBのテスト用.
 -}
data CreateDataRequest = CreateDataRequest {
    cdrName :: Text
} deriving (Generic, Show)
instance FromJSON CreateDataRequest
instance FromText CreateDataRequest where
    parser = textToJsonParser

data DynamoDbRecord = DynamoDbRecord {
    ddrId   :: String
  , ddrName :: Text
} deriving (Generic, Show)
instance ToJSON DynamoDbRecord
instance ToText DynamoDbRecord where
    toText = jsonToText
instance ToText [DynamoDbRecord] where
    toText = jsonToText
emptyDynamoDbRecord = DynamoDbRecord "" ""

instance ToText [Text] where
    toText = jsonToText
