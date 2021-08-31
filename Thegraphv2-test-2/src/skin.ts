import { BigInt, log} from "@graphprotocol/graph-ts"
import { skinsabi, PriceChanged } from "../generated/templates/Skins/skinsabi"
import { skin } from "../generated/schema"

export function handlePriceChanged(event: PriceChanged): void {
  log.info("YAHAN,{}",[""]);
  log.info("here in price changed {}", [""]);

  let valSkin = skin.load(event.transaction.from.toHex())

  if (valSkin == null) {
    valSkin = new skin(event.transaction.hash.toHex() + "-" + event.logIndex.toString())
    valSkin.price = event.params.newPrice
    let skinContract = skinsabi.bind(event.address)
    valSkin.name = skinContract.getName()
    valSkin.vfx = skinContract.getVfx()
    valSkin.owner = skinContract.getOwner()
  
    valSkin.save()
  }

 
 

 
}
