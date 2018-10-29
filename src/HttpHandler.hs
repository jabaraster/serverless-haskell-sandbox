module HttpHandler where

import           AWSLambda.Events.APIGateway
import           Control.Lens
import           Data.Text                   (Text)
import qualified Data.Text                   as DT (pack)
import           Network.HTTP.Types

import           Lib
import           Types

core :: APIGatewayProxyRequest () -> HttpInfo
core req = HttpInfo {
             pathParameters = req^.agprqPathParameters
           , headers = map cnv $ req^.agprqHeaders
           }
  where
    cnv :: Header -> (Text, Text)
    cnv (name, value) = (DT.pack $ show name, byteStringToText value)
