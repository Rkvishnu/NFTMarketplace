import React from "react";
import Image from "next/image";
import Style from "./HeroSection.module.css";
import { Button } from "../componentsindex";
import images from "../../img";

const HeroSection = () => {
  return (
    <div className={Style.HeroSection}>
      <div className={Style.HeroSection_box}>
        <div className={Style.HeroSection_box_left}>
          <h1>Discover,Collect and Sell Extraordinary NFTs 🧗</h1>
          <p>
            Discover the most outstanding NFTs on all topic your NFTs and Sell
            them
          </p>
    <Button btnName='Start your search here'/>
        </div>
        <div className={Style.HeroSection_box_right}>
            <Image src={images.hero}
            alt ="hero image"
            height={500}
            width={600}
            />

        </div>
      </div>
    </div>
  );
};

export default HeroSection;
