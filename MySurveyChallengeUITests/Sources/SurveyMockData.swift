//
//  SurveyMockData.swift
//  MySurveyChallengeUITests
//
//  Created by Nguyen Truong Luu on 4/23/24.
//

import Foundation

enum SurveyMockData {
    static let json =
        """
            {
                "data": [
                    {
                        "id": "d5de6a8f8f5f1cfe51bc",
                        "type": "survey_simple",
                        "attributes": {
                            "title": "Scarlett Bangkok",
                            "description": "We'd love ot hear from you!",
                            "thank_email_above_threshold": "<span style=\"font-family:arial,helvetica,sans-serif\"><span style=\"font-size:14px\">Dear {name},<br /><br />Thank you for visiting Scarlett Wine Bar &amp; Restaurant at Pullman Bangkok Hotel G &nbsp;and for taking the time to complete our guest feedback survey!<br /><br />Your feedback is very important to us and each survey is read individually by the management and owners shortly after it is sent. We discuss comments and suggestions at our daily meetings and use them to constantly improve our services.<br /><br />We would very much appreciate it if you could take a few more moments and review us on TripAdvisor regarding your recent visit. By <a href=\"https://www.tripadvisor.com/Restaurant_Review-g293916-d2629404-Reviews-Scarlett_Wine_Bar_Restaurant-Bangkok.html\">clicking here</a> you will be directed to our page.&nbsp;<br /><br />Thank you once again and we look forward to seeing you soon!<br /><br />The Team at Scarlett Wine Bar &amp; Restaurant&nbsp;</span></span><span style=\"font-family:arial,helvetica,sans-serif; font-size:14px\">Pullman Bangkok Hotel G</span>",
                            "thank_email_below_threshold": "<span style=\"font-size:14px\"><span style=\"font-family:arial,helvetica,sans-serif\">Dear {name},<br /><br />Thank you for visiting&nbsp;</span></span><span style=\"font-family:arial,helvetica,sans-serif; font-size:14px\">Uno Mas at Centara Central World&nbsp;</span><span style=\"font-size:14px\"><span style=\"font-family:arial,helvetica,sans-serif\">&nbsp;and for taking the time to complete our customer&nbsp;feedback survey.</span></span><br /><br /><span style=\"font-family:arial,helvetica,sans-serif; font-size:14px\">The Team at&nbsp;</span><span style=\"font-family:arial,helvetica,sans-serif\"><span style=\"font-size:14px\">Scarlett Wine Bar &amp; Restaurant&nbsp;</span></span><span style=\"font-family:arial,helvetica,sans-serif; font-size:14px\">Pullman Bangkok Hotel G</span>",
                            "is_active": true,
                            "cover_image_url": "https://ucarecdn.com/62886578-df8b-4f65-902e-8e88d97748b8/-/quality/smart_retina/-/format/auto/",
                            "created_at": "2017-01-23T07:48:12.991Z",
                            "active_at": "2015-10-08T07:04:00.000Z",
                            "inactive_at": null,
                            "survey_type": "Restaurant"
                        }
                    },
                    {
                        "id": "ed1d4f0ff19a56073a14",
                        "type": "survey_simple",
                        "attributes": {
                            "title": "ibis Bangkok Riverside",
                            "description": "We'd love to hear from you!",
                            "thank_email_above_threshold": "Dear {name},<br /><br />Thank you for visiting Beach Republic and for taking the time to complete our brief survey. We are thrilled that you enjoyed your time with us! If you have a moment, we would be greatly appreciate it if you could leave a short review on <a href=\"http://www.tripadvisor.com/Hotel_Review-g1188000-d624070-Reviews-Beach_Republic_The_Residences-Lamai_Beach_Maret_Ko_Samui_Surat_Thani_Province.html\">TripAdvisor</a>. It helps to spread the word and let others know about the Beach Republic Revolution!<br /><br />Thank you again and we look forward to welcoming you back soon.<br /><br />Sincerely,<br /><br />Beach Republic Team",
                            "thank_email_below_threshold": "Dear {name},<br /><br />Thank you for visiting Beach Republic and for taking the time to complete our brief survey. We are constantly striving to improve and your feedback allows us to help improve the experience for you on your next visit. Each survey is read individually by senior staff and discussed with the team in daily meetings.&nbsp;<br /><br />Thank you again and we look forward to welcoming you back soon.<br /><br />Sincerely,<br /><br />Beach Republic Team",
                            "is_active": true,
                            "cover_image_url": "https://ucarecdn.com/e4bc340d-27e8-4698-80f2-91e0e5c91a13/-/quality/smart_retina/-/format/auto/",
                            "created_at": "2017-01-23T03:32:24.585Z",
                            "active_at": "2016-01-22T04:12:00.000Z",
                            "inactive_at": null,
                            "survey_type": "Hotel"
                        }
                    },
                    {
                        "id": "270130035d415c1d90bb",
                        "type": "survey_simple",
                        "attributes": {
                            "title": "21 on Rajah",
                            "description": "We'd love to hear from you!",
                            "thank_email_above_threshold": null,
                            "thank_email_below_threshold": null,
                            "is_active": true,
                            "cover_image_url": "https://ucarecdn.com/ed35738a-31e0-476c-8af3-1cf3dfb92ad9/-/quality/smart_retina/-/format/auto/",
                            "created_at": "2017-01-20T10:08:42.531Z",
                            "active_at": "2017-01-20T10:08:42.512Z",
                            "inactive_at": null,
                            "survey_type": "Restaurant"
                        }
                    },
                    {
                        "id": "a83d91f5518e5c14a8bf",
                        "type": "survey_simple",
                        "attributes": {
                            "title": "Let's Chick",
                            "description": "We'd love to hear from you!",
                            "thank_email_above_threshold": "<div><span style=\"font-size:14px\"><span style=\"font-family:arial,helvetica,sans-serif\">Dear {name},</span></span></div><div>&nbsp;</div><div><span style=\"font-size:14px\"><span style=\"font-family:arial,helvetica,sans-serif\">Thank you for visiting Bei Otto and taking the time to complete our brief survey. We constantly strive to improve our guests&#39; experience and your essential feedback will go a long way in helping us achieve our aim. Each and every survey is read carefully and discussed by our team in daily meetings.</span></span></div><div>&nbsp;</div><div><span style=\"font-size:14px\"><span style=\"font-family:arial,helvetica,sans-serif\">We would deeply appreciate it if you would be willing to share some recommendations from our menu, the service you received from our team and some memorable pictures of your meal on TripAdvisor by <a href=\"https://www.tripadvisor.com/Restaurant_Review-g293916-d833538-Reviews-Bei_Otto-Bangkok.html\">clicking here</a> ; you will then be directed to our page.&nbsp;</span></span></div><div><span style=\"font-size:14px\"><span style=\"font-family:arial,helvetica,sans-serif\">&nbsp;</span></span></div><div><span style=\"font-size:14px\"><span style=\"font-family:arial,helvetica,sans-serif\">We are looking forward to welcoming you again to Bei Otto hopefully in the very near future.</span></span></div><div><span style=\"font-size:14px\"><span style=\"font-family:arial,helvetica,sans-serif\">&nbsp;</span></span></div><div><span style=\"font-size:14px\"><span style=\"font-family:arial,helvetica,sans-serif\">Warm regards,</span></span></div><div><span style=\"font-size:14px\"><span style=\"font-family:arial,helvetica,sans-serif\">Bei Otto</span></span></div><br />&nbsp;",
                            "thank_email_below_threshold": "<div><span style=\"font-size:14px\"><span style=\"font-family:arial,helvetica,sans-serif\">Dear {name},</span></span></div><div>&nbsp;</div><div><span style=\"font-size:14px\"><span style=\"font-family:arial,helvetica,sans-serif\">Thank you for visiting Bei Otto and for taking the time to complete our brief survey.&nbsp;</span></span></div><div><span style=\"font-size:14px\"><span style=\"font-family:arial,helvetica,sans-serif\">&nbsp;</span></span></div><div><span style=\"font-size:14px\"><span style=\"font-family:arial,helvetica,sans-serif\">We would like to sincerely apologise that we failed to delight you while dining with us and truly regret that you found our service not up to our usual high standards. Your comments on your survey have been well noted and will be shared with our team for immediate improvement as we consider the points you raised to be one of our priorities. Please do not hesitate to share more details of your dining experience directly &nbsp;with me via info@beiotto.com so as we can improve our services for your next visit.&nbsp;</span></span></div><div><span style=\"font-size:14px\"><span style=\"font-family:arial,helvetica,sans-serif\">&nbsp;</span></span></div><div><span style=\"font-size:14px\"><span style=\"font-family:arial,helvetica,sans-serif\">We hope you will give us another chance to show you a true Bei Otto experience in hopefully the not too distant future.</span></span></div><div><span style=\"font-size:14px\"><span style=\"font-family:arial,helvetica,sans-serif\">&nbsp;</span></span></div><div><span style=\"font-size:14px\"><span style=\"font-family:arial,helvetica,sans-serif\">Sincerely,</span></span></div><div><span style=\"font-size:14px\"><span style=\"font-family:arial,helvetica,sans-serif\">Bei Otto</span></span></div><div>&nbsp;</div>",
                            "is_active": true,
                            "cover_image_url": "https://ucarecdn.com/456f46fe-637c-4ed1-9d6d-67f4fd0f2bde/-/quality/smart_retina/-/format/auto/",
                            "created_at": "2017-01-19T06:03:42.220Z",
                            "active_at": "2016-12-15T02:39:00.000Z",
                            "inactive_at": null,
                            "survey_type": "Restaurant"
                        }
                    }
                ],
                "meta": {
                    "page": 1,
                    "pages": 5,
                    "page_size": 4,
                    "records": 20
                }
            }
        """
}
