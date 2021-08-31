import { BigInt } from "@graphprotocol/graph-ts"
import { Valorant, SkinCreated } from "../generated/Valorant/Valorant"
import { valFactory } from "../generated/schema"
import {Skins} from "../generated/templates"

export function handleSkinCreated(event: SkinCreated): void {
  // Entities can be loaded from the store using a string ID; this ID
  // needs to be unique across all entities of the same type
  let valSkinFactory = valFactory.load(event.transaction.from.toHex())

  // Entities only exist after they have been saved to the store;
  // `null` checks allow to create entities on demand
  if (valSkinFactory == null) {
    valSkinFactory = new valFactory(event.transaction.hash.toHex() + "-" + event.logIndex.toString())
    valSkinFactory.skinAddr = event.params.skinAddr
    valSkinFactory.skinSalt = event.params.skinSalt
    let contract = Valorant.bind(event.address)
    valSkinFactory.count = contract.getSkinLength()
    Skins.create(event.params.skinAddr)
    valSkinFactory.save()


    // valSkinFactory fields can be set using simple assignments
    
  }



 

  // valSkinFactory fields can be set based on event parameters


  // Entities can be written to the store with `.save()`


  // Note: If a handler doesn't require existing field values, it is faster
  // _not_ to load the entity from the store. Instead, create it fresh with
  // `new Entity(...)`, set the fields that should be updated and save the
  // entity back to the store. Fields that were not set or unset remain
  // unchanged, allowing for partial updates to be applied.

  // It is also possible to access smart contracts from mappings. For
  // example, the contract that has emitted the event can be connected to
  // with:
  //
  // let contract = Contract.bind(event.address)
  //
  // The following functions can then be called on this contract to access
  // state variables and other data:
  //
  // - contract.createContractwithArguments(...)
  // - contract.getSkinLength(...)
  // - contract.skinIDtoAddress(...)
}
