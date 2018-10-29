module Main where

import           Control.Lens

import           AWSLambda.Events.APIGateway

import           GetDataHandler
import           Types

main :: IO ()
main = apiGatewayMain handler

handler :: APIGatewayProxyRequest () -> IO (APIGatewayProxyResponse [DynamoDbRecord])
handler req = do
    mRes <- core
    case mRes of
      Just res -> return $ responseOK & responseBody?~res
      Nothing  -> return $ response 500
