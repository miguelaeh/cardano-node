{-# LANGUAGE OverloadedStrings #-}

module Spec.Chairman.Cardano
  ( hprop_chairman
  ) where

import           Data.Function
import           Data.Functor
import           Data.Maybe
import           Spec.Chairman.Chairman (chairmanOver)

import qualified Hedgehog as H
import qualified Hedgehog.Extras.Test.Base as H
import qualified Test.Base as H
import qualified Testnet.Cardano as H
import qualified Testnet.Conf as H

{- HLINT ignore "Reduce duplication" -}
{- HLINT ignore "Redundant <&>" -}
{- HLINT ignore "Redundant flip" -}

hprop_chairman :: H.Property
hprop_chairman = H.integration . H.runFinallies . H.workspace "chairman" $ \tempAbsPath' -> do
  conf <- H.mkConf tempAbsPath' Nothing

  allNodes <- fmap H.nodeName . H.allNodes <$> H.testnet H.defaultTestnetOptions conf

  chairmanOver 120 50 conf allNodes
