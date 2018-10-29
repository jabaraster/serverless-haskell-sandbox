module Main where

import           AWSLambda.Events.APIGateway
import           Control.Lens
import           Data.Text                   (Text)

import           HelloHandler
-- 以下は()をFromTextのインスタンスにするために必要
import           Types

main :: IO ()
main = apiGatewayMain handler

handler :: APIGatewayProxyRequest () -> IO (APIGatewayProxyResponse Text)
handler request = pure $ responseOK & responseBody?~core

