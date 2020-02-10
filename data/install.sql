--
-- Base Table
--
CREATE TABLE `offer` (
  `Offer_ID` int(11) NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_date` datetime NOT NULL,
  `modified_by` int(11) NOT NULL,
  `modified_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `offer`
  ADD PRIMARY KEY (`Offer_ID`);

ALTER TABLE `offer`
  MODIFY `Offer_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Permissions
--
INSERT INTO `permission` (`permission_key`, `module`, `label`, `nav_label`, `nav_href`, `show_in_menu`) VALUES
('add', 'Digitag\\Offer\\Controller\\OfferController', 'Add', '', '', 0),
('edit', 'Digitag\\Offer\\Controller\\OfferController', 'Edit', '', '', 0),
('index', 'Digitag\\Offer\\Controller\\OfferController', 'Index', 'Offers', '/offer', 1),
('list', 'Digitag\\Offer\\Controller\\ApiController', 'List', '', '', 1),
('view', 'Digitag\\Offer\\Controller\\OfferController', 'View', '', '', 0),
('dump', 'Digitag\\Offer\\Controller\\ExportController', 'Excel Dump', '', '', 0),
('index', 'Digitag\\Offer\\Controller\\SearchController', 'Search', '', '', 0);

--
-- Form
--
INSERT INTO `core_form` (`form_key`, `label`, `entity_class`, `entity_tbl_class`) VALUES
('offer-single', 'Offer', 'Digitag\\Offer\\Model\\Offer', 'Digitag\\Offer\\Model\\OfferTable');

--
-- Index List
--
INSERT INTO `core_index_table` (`table_name`, `form`, `label`) VALUES
('offer-index', 'offer-single', 'Offer Index');

--
-- Tabs
--
INSERT INTO `core_form_tab` (`Tab_ID`, `form`, `title`, `subtitle`, `icon`, `counter`, `sort_id`, `filter_check`, `filter_value`) VALUES ('offer-base', 'offer-single', 'Offer', 'Base', 'fas fa-cogs', '', '0', '', '');

--
-- Buttons
--
INSERT INTO `core_form_button` (`Button_ID`, `label`, `icon`, `title`, `href`, `class`, `append`, `form`, `mode`, `filter_check`, `filter_value`) VALUES
(NULL, 'Save Offer', 'fas fa-save', 'Save Offer', '#', 'primary saveForm', '', 'offer-single', 'link', '', ''),
(NULL, 'Edit Offer', 'fas fa-edit', 'Edit Offer', '/offer/edit/##ID##', 'primary', '', 'offer-view', 'link', '', ''),
(NULL, 'Add Offer', 'fas fa-plus', 'Add Offer', '/offer/add', 'primary', '', 'offer-index', 'link', '', ''),
(NULL, 'Export Offers', 'fas fa-file-excel', 'Export Offers', '/offer/export', 'primary', '', 'offer-index', 'link', '', ''),
(NULL, 'Find Offers', 'fas fa-searh', 'Find Offers', '/offer/search', 'primary', '', 'offer-index', 'link', '', ''),
(NULL, 'Export Offers', 'fas fa-file-excel', 'Export Offers', '#', 'primary initExcelDump', '', 'offer-search', 'link', '', ''),
(NULL, 'New Search', 'fas fa-searh', 'New Search', '/offer/search', 'primary', '', 'offer-search', 'link', '', '');

--
-- Fields
--
INSERT INTO `core_form_field` (`Field_ID`, `type`, `label`, `fieldkey`, `tab`, `form`, `class`, `url_view`, `url_list`, `show_widget_left`, `allow_clear`, `readonly`, `tbl_cached_name`, `tbl_class`, `tbl_permission`) VALUES
(NULL, 'text', 'Name', 'label', 'offer-base', 'offer-single', 'col-md-3', '/offer/view/##ID##', '', 0, 1, 0, '', '', '');

--
-- User XP Activity
--
INSERT INTO `user_xp_activity` (`Activity_ID`, `xp_key`, `label`, `xp_base`) VALUES
(NULL, 'offer-add', 'Add New Offer', '50'),
(NULL, 'offer-edit', 'Edit Offer', '5'),
(NULL, 'offer-export', 'Edit Offer', '5');

COMMIT;