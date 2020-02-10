<?php
/**
 * OfferTable.php - Offer Table
 *
 * Table Model for Offer
 *
 * @category Model
 * @package Offer
 * @author Verein onePlace
 * @copyright (C) 2020 Verein onePlace <admin@1plc.ch>
 * @license https://opensource.org/licenses/BSD-3-Clause
 * @version 1.0.0
 * @since 1.0.0
 */

namespace Digitag\Offer\Model;

use Application\Controller\CoreController;
use Application\Model\CoreEntityTable;
use Laminas\Db\TableGateway\TableGateway;
use Laminas\Db\ResultSet\ResultSet;
use Laminas\Db\Sql\Select;
use Laminas\Db\Sql\Where;
use Laminas\Paginator\Paginator;
use Laminas\Paginator\Adapter\DbSelect;

class OfferTable extends CoreEntityTable {

    /**
     * OfferTable constructor.
     *
     * @param TableGateway $tableGateway
     * @since 1.0.0
     */
    public function __construct(TableGateway $tableGateway) {
        parent::__construct($tableGateway);

        # Set Single Form Name
        $this->sSingleForm = 'offer-single';
    }

    /**
     * Get Offer Entity
     *
     * @param int $id
     * @param string $sKey
     * @return mixed
     * @since 1.0.0
     */
    public function getSingle($id,$sKey = 'Offer_ID') {
        # Use core function
        return $this->getSingleEntity($id,$sKey);
    }

    /**
     * Save Offer Entity
     *
     * @param Offer $oOffer
     * @return int Offer ID
     * @since 1.0.0
     */
    public function saveSingle(Offer $oOffer) {
        $aData = [
            'label' => $oOffer->label,
        ];

        $aData = $this->attachDynamicFields($aData,$oOffer);

        $id = (int) $oOffer->id;

        if ($id === 0) {
            # Add Metadata
            $aData['created_by'] = CoreController::$oSession->oUser->getID();
            $aData['created_date'] = date('Y-m-d H:i:s',time());
            $aData['modified_by'] = CoreController::$oSession->oUser->getID();
            $aData['modified_date'] = date('Y-m-d H:i:s',time());

            # Insert Offer
            $this->oTableGateway->insert($aData);

            # Return ID
            return $this->oTableGateway->lastInsertValue;
        }

        # Check if Offer Entity already exists
        try {
            $this->getSingle($id);
        } catch (\RuntimeException $e) {
            throw new \RuntimeException(sprintf(
                'Cannot update offer with identifier %d; does not exist',
                $id
            ));
        }

        # Update Metadata
        $aData['modified_by'] = CoreController::$oSession->oUser->getID();
        $aData['modified_date'] = date('Y-m-d H:i:s',time());

        # Update Offer
        $this->oTableGateway->update($aData, ['Offer_ID' => $id]);

        return $id;
    }

    /**
     * Generate new single Entity
     *
     * @return Offer
     * @since 1.0.0
     */
    public function generateNew() {
        return new Offer($this->oTableGateway->getAdapter());
    }
}