// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/utils/Counters.sol";

contract Blog {
    using Counters for Counters.Counter;

    Counters.Counter private blogId;

    struct blogStruct {
        uint256 blogId;
        string title;
        string blogUrl;
        string category;
        address owner;
        uint timestamp;
    }

    mapping (uint256 => blogStruct) idToBlog;

    event createBlog(uint256 _blogId, string _title, string indexed _category);

    function createNewBlog(string memory _title, string memory _blogUrl, string memory _category) public returns(uint256) {
        blogId.increment();
        uint256 currentBlogId = blogId.current();
        idToBlog[currentBlogId] = blogStruct(
            currentBlogId,
            _title,
            _blogUrl,
            _category,
            msg.sender,
            block.timestamp
        );
        emit createBlog(currentBlogId, _title, _category);
        return currentBlogId;
    }

    function getBlogById(uint256 _blogId) public view returns(blogStruct memory){
        return idToBlog[_blogId];
    }

    function getAllBlogs() public view returns(blogStruct[] memory){
        uint256 blogCount = blogId.current();
        uint256 currentIndex = 0;
        blogStruct[] memory blogs = new blogStruct[](blogCount);

        for (uint i = 0; i < blogCount; i++) {
            blogStruct storage currentBlog = idToBlog[i+1];
            blogs[currentIndex] = currentBlog;
            currentIndex += 1; 
        }
        return blogs;
    }

    function totalBlogs() public view returns(uint256) {
        return blogId.current();
    }

    function getMyBlogs() public view returns(blogStruct[] memory){
        uint256 blogCount = blogId.current();
        uint256 currentIndex = 0;
        uint256 myBlogCount = 0;

        for (uint256 i = 0; i < blogCount; i++) {
            if (idToBlog[i + 1].owner == msg.sender){
                myBlogCount += 1;
            }
        }

        blogStruct[] memory myBlogs = new blogStruct[](myBlogCount);
        for (uint256 i = 0; i < blogCount; i++) {
            if (idToBlog[i + 1].owner == msg.sender){
                blogStruct storage currentBlog = idToBlog[i + 1];
                myBlogs[currentIndex] = currentBlog; 
            }
        }
        return myBlogs;
    }

}