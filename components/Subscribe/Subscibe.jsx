import React from "react";
import Image from "next/image";
import images from "../../img";
import { RiSendPlaneFill } from "react-icons/ri";

import Style from "./Subscribe.module.css";

const Subscibe = () => {
  return (
    <div className={Style.subscribe_}>
      <div className={Style.subscribe_box}>
        <div className={Style.subscribe_box_left}>
          <h2>Never Miss A Drop</h2>
          <p>
            {" "}
            Subcribe to our super-exclusive drop list and be the first to know
            abour upcoming drops
          </p>

          <div className={Style.subscribe_box_left_box}>
            <span>01</span>
            <small>Get More Discount</small>
          </div>

          <div className={Style.subscribe_box_left_box}>
            <span>02</span>
            <small>Get Premium Magazines</small>
          </div>
          <div className={Style.subscribe_box_left_input}>
            <input type="email" placeholder="enter your email"></input>
            <RiSendPlaneFill
              className={Style.subscribe_box_left_input_icon}
            />
             
          </div>
          <div className={Style.subscribe_box_right}>
          <Image
            src={images.update}
            alt="get update"
            height={600}
            width={800}
          />
        </div>
        </div>
      </div>
    </div>
  );
};

export default Subscibe;
