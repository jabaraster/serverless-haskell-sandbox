module S3Handler where

import           Control.Lens
import           Data.Text             (Text)

import           Network.AWS.Data.Text
import           Network.AWS.S3

import           AWSLib

core :: IO ([Text])
core = do
    res <- runListBuckets =<< awsEnv
    mapM_ (print . cnv) $ res^.lbrsBuckets
    pure $ map cnv $ res^.lbrsBuckets
  where
    cnv :: Bucket -> Text
    cnv b = toText $ b^.bName
