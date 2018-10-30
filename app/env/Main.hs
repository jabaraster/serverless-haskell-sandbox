module Main where

import           AWSLambda.Events.APIGateway
import           Control.Lens
import           Data.Text                   (pack)
import           System.Environment
-- 以下は()をFromTextのインスタンスにするために必要
import           Types

main :: IO ()
main = apiGatewayMain handler

handler :: APIGatewayProxyRequest () -> IO (APIGatewayProxyResponse [(String, String)])
handler request = do
    envs <- getEnvironment
    return $ responseOK & responseBody?~envs
