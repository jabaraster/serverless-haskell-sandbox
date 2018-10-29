module Main where

import           Control.Lens
import           Data.Aeson.TextValue
import           Data.Text                   (unpack)

import           AWSLambda.Events.APIGateway

import           PostDataHandler
import           Types

main :: IO ()
main = apiGatewayMain handler

handler :: APIGatewayProxyRequest CreateDataRequest -> IO (APIGatewayProxyResponse DynamoDbRecord)
handler request =
  case request^.agprqBody of
    Nothing -> return $ responseBadRequest&responseBody?~emptyDynamoDbRecord
    Just (TextValue body) -> do
      res <- core body
      case res of
        Left msg -> do
          putStrLn $ unpack msg
          return $ (response 500)&responseBody ?~ emptyDynamoDbRecord
        Right rec -> return $ responseOK&responseBody ?~ rec
