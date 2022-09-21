import React from "react";
//INTERNAL IMPORT
import Style from "../styles/index.module.css";
import {
  BigNFTSlider,
  HeroSection,
  Service,
  Subscribe,
  Title,
  Category,
  Filter,
  NFTCard,
  Collection,
  FollowerTab,
} from "../components/componentsindex.js";
// we are not importing Navabr and Footer folder in indexedDB.js because we them in every page
const Home = () => {
  return (
    <div className={Style.homePage}>
      <HeroSection />
      <Service />
      <BigNFTSlider />
      <Title
        heading="Filter By Collection"
        paragraph="Discover the most outstanding NFTs in all topics of life."
      />
      <FollowerTab/>
      
      <Collection/>

      <Title
        heading="Featured NFTs"
        paragraph="Discover the most outstanding NFTs in all topics of life."
      />
      <Filter />

      <NFTCard/>

      <Title
        heading="Browse by category"
        paragraph="Explore the NFTs in the most featured categories."
      />
      <Category />
      <Subscribe />
    </div>
  );
};

export default Home;
