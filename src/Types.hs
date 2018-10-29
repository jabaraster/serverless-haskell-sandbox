{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
module Types where

import           Data.Aeson
import qualified Data.HashMap.Strict   as H
import           GHC.Generics

import           Network.AWS.Data.Text

import           Lib

type Headers = [(Text, Text)]

data HttpInfo = HttpInfo {
    pathParameters :: H.HashMap Text Text
  , headers        :: [(Text, Text)]
} deriving (Generic, Show)

instance ToJSON HttpInfo
instance ToText HttpInfo where
    toText = jsonToText

instance ToText () where
    toText _ = ""
instance FromText () where
    parser = return ()
