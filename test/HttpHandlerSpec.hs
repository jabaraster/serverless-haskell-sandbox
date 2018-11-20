module HttpHandlerSpec where

import           Debug.Trace

import           Test.Hspec

import           HttpHandler
import           TestLib

spec :: Spec
spec = do
    it "Http handler test." $ do
        res <- core apiGatewayProxyRequest
        print res
