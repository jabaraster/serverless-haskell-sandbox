module Main where

import           AWSLambda.Events.APIGateway
import           Control.Lens
import           Data.Aeson
import           Data.Text                   (Text)

import           S3Handler
-- 以下は()をFromTextのインスタンスにするために必要
import           Types

main :: IO ()
main = apiGatewayMain handler

handler :: APIGatewayProxyRequest () -> IO (APIGatewayProxyResponse [Text])
handler request = do
  res <- core
  pure $ responseOK & responseBody?~res
